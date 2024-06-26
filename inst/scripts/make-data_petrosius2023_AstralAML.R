
####---- Petrosius et al. 2023 ---####

library(SingleCellExperiment)
library(scp)
library(tidyverse)
dataDir <- "https://dataverse.uclouvain.be/api/access/datafile/"

####---- Create sample annotation ----####

## Retrieve annotation files
## index_map.tab file
facs <- read.delim(url(paste0(dataDir, "24337")))
## msRuns_overview.csv file
map <- read.csv(url(paste0(dataDir, "24339")), row.names = "X")

## Map FACS data with MS runs
facs_mapped <- inner_join(map, facs, by = "Well")

## Create metadata
meta <-
  facs_mapped |>
  mutate(filename = sub(".*RunSummaries/", "", filename),
         filename = sub(".raw.*", "", filename),
         fileID = paste(CellType, Cell.Number, sep = "_"),
         quant = "quant") |>
  select(-Cell.Type) |>
  arrange(by_group = CellType, Cell.Number)

colnames(meta) <- gsub("_$" , "", gsub("\\.+", "_", colnames(meta)))

####---- PSM data ----####

## PSM data has been shared by the authors in PEPQuant file from
## spectronaut

## Retrieve ID/quant file
## '20240201_130747_PEPQuant (Normal).tsv' file
psm <-
  read.delim(paste0(dataDir, "24335"))

psm$fileID <- sub(".*sc8227_" , "", psm$R.FileName)

colnames(psm)[colnames(psm) == "FG.MS1Quantity"] <- "quant"

## QFeatures object
petrosius2023_AstralAML <-
  readSCP(featureData = psm,
          colData = meta,
          batchCol = "fileID",
          channelCol = "quant",
          sep = "_")

####---- Generate peptide data ----####

## Peptide data is generated by aggregation of the psm data

petrosius2023_AstralAML <-
  aggregateFeatures(petrosius2023_AstralAML,
                    i = 1:length(petrosius2023_AstralAML),
                    fcol = "PEP.StrippedSequence",
                    fun = colMedians,
                    name = paste0("peptide_", names(petrosius2023_AstralAML)))

petrosius2023_AstralAML <-
  joinAssays(petrosius2023_AstralAML,
             i = grep("peptide", names(petrosius2023_AstralAML)),
             name = "peptides")

petrosius2023_AstralAML <-
  petrosius2023_AstralAML[, , !grepl("peptide_", names(petrosius2023_AstralAML))]


####---- Retrieve protein data ----####

## Protein data has been shared by the authors in a PGQuant file from
## spectronaut
## 20240201_130747_PGQuant (Normal).tsv file
prot <-
  read.delim(paste0(dataDir, "24334"))

prot$R.FileName <- sub(".*Bremen/" , "", prot$R.Raw.File.Name)
prot$R.FileName <- sub(".raw" , "", prot$R.FileName)
prot$fileID <- sub(".*sc8227_" , "", prot$R.FileName)

colnames(prot)[colnames(prot) == "PG.Quantity"] <- "quant"

## Pivot to wide format
prot <- prot |>
  select(PG.Genes, PG.ProteinAccessions, PG.ProteinDescriptions,
         quant, fileID) |>
  pivot_wider(names_from = fileID,
              values_from = quant,
              names_glue = "{fileID}_quant")

## Read as SingleCellExperiment object
prot_assay <-
  readSingleCellExperiment(prot,
                           ecol = colnames(prot)[grep("quant",
                                                      colnames(prot))],
                           fnames = "PG.ProteinAccessions")

## Add assay to petrosius2023_AstralAML object
petrosius2023_AstralAML <-
  addAssay(petrosius2023_AstralAML,
           prot_assay,
           name = "proteins")

## Add link from peptide data to protein data
petrosius2023_AstralAML <- addAssayLink(petrosius2023_AstralAML,
                              from = "peptides",
                              to = "proteins",
                              varFrom = "PG.ProteinAccessions",
                              varTo = "PG.ProteinAccessions")

# Save data as Rda file
save(petrosius2023_AstralAML,
     file = "~/2022-phd-samuel-gregoire/petrosius2023_AstralAML.Rda",
     compress = "xz",
     compression_level = 9)
