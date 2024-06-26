% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{liang2020_hela}
\alias{liang2020_hela}
\title{Liang et al. 2020 (Anal. Chem.): HeLa cells (MaxQuant preprocessing)}
\format{
A \link{QFeatures} object with 17 assays, each assay being a
\link{SingleCellExperiment} object:
\itemize{
\item \verb{HeLa_*}: 15 assays containing PSM data.
\item \code{peptides}: quantitative data for 48705 peptides in 15 samples
(all runs are combined).
\item \code{proteins}: quantitative data for 3970 protein groups in 15
samples (all runs combined).
}

Sample annotation is stored in \code{colData(liang2020_hela())}.
}
\source{
The PSM data can be downloaded from the PRIDE repository
PXD021882 The source link is:
http://ftp.pride.ebi.ac.uk/pride/data/archive/2020/12/PXD021882/
}
\usage{
liang2020_hela
}
\description{
Single-cell proteomics data from HeLa cells using the autoPOTS
acquisition workflow. The samples contain either no cells (blanks),
1 cell, 10 cells, 150 cells or 500 cells. Samples containing
between 0 and 10 cells are isolated using micro-pipetting while
samples containing between 150 and 500 cells were prepared using
dilution of a bulk sample.
}
\section{Acquisition protocol}{


The data were acquired using the following setup. More information
can be found in the source article (see \code{References}).
\itemize{
\item \strong{Cell isolation}: The HeLa cells come from a commercially
available cell line. Samples containing between 0 and 10 cells
were isolated using micro-manipulation and the counts were
validated using a microscope. Samples containing between 150 and
500 cells were prepared by diluting a bulk sample and the exact
counts were evaluated by obtaining phtotmicrographs.
\item \strong{Sample preparation} performed using the autoPOTS worflow that
relied on the OT-2 pipeting robot. Cell are lysed using
sonication. Samples are then processed by successive incubation
with DTT (reduction), then IAA (alkylation), then Lys-C and
trypsin (protein digestion).
\item \strong{Separation}: Samples were injected on the column using a
modified Ultimate WPS-3000 TPL autosampler coupled to an UltiMate
3000 RSLCnano pump. The LC column is a home-packed nanoLC column
(45cm x 30um; 40nL/min)
\item \strong{Ionization}: Nanospray Flex ion source (2,000V)
\item \strong{Mass spectrometry}: Orbitrap Exploris 480. MS1 settings:
accumulation time = 250 ms (0-10 cells) or 100 ms (150-500 cells);
resolution = 120,000; AGC = 100\\%. MS2 settings: exlusion
duration = 90 s (0-10 cells) or 60 s (150-500 cells) ; accumulation
time = 500 ms (0-1 cell), 250 ms (10 cells), 100 ms (150 cells)
or 50 ms (500 cells); resolution = 60,000 (0-10 cells) or 30,000
(150-500 cells); AGC = 5E3 (0-1 cells) or 1E4 (10-500 cells).
\item \strong{Data analysis}: MaxQuant (v1.6.7.0) and the search database
is Swiss-Prot (July 2020).
}
}

\section{Data collection}{


All data were collected from the PRIDE repository (accession ID:
PXD021882).

The sample annotations were collected from the methods section and
from table S3 in the paper.

The PSM data were found in the \code{evidence.txt} file. The data were
converted to a \link{QFeatures} object using the \code{\link[scp:readSCP]{scp::readSCP()}}
function.

The peptide data were found in the \code{peptides.txt} file. The column
names holding the quantitative data were adapted to match the
sample names in the \link{QFeatures} object. The data were then
converted to a \link{SingleCellExperiment} object and then inserted in
the \link{QFeatures} object. Links between the PSMs and the peptides
were added

A similar procedure was applied to the protein data. The data were
found in the \code{proteinGroups.txt} file. The column names were
adapted, the data were converted to a \link{SingleCellExperiment}
object and then inserted in the \link{QFeatures} object. Links between
the peptides and the proteins were added
}

\examples{
\donttest{
liang2020_hela()
}

}
\references{
Liang, Yiran, Hayden Acor, Michaela A. McCown, Andikan J. Nwosu,
Hannah Boekweg, Nathaniel B. Axtell, Thy Truong, Yongzheng Cong,
Samuel H. Payne, and Ryan T. Kelly. 2020. “Fully Automated Sample
Processing and Analysis Workflow for Low-Input Proteome
Profiling.” Analytical Chemistry, December.
(\href{https://doi.org/10.1021/acs.analchem.0c04240}{link to article}).
}
\keyword{datasets}
