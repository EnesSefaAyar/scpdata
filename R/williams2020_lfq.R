##' Williams et al. 2020 (Anal. Chem.): MCF10A cell line
##'
##' Single-cell label free proteomics data from a MCF10A cell line
##' culture. The data were acquired using a label-free quantification
##' protocole based on the nanoPOTS technology. The objective was to
##' test 2 elution gradients for single-cell applications and to
##' demonstrate successful use of the new nanoPOTS autosampler
##' presented in the article. The samples contain either no cells,
##' single cells, 3 cells, 10 cells  50 cells.
##'
##' @format A [QFeatures] object with 9 assays, each assay being a
##' [SingleCellExperiment] object:
##'
##' - `peptides_[30 or 60]min_[intensity or LFQ]`: 3 assays
##'   containing peptide intensities or LFQ normalized
##'   quantifications (see `References`) for either a 30min or a 60 min
##'   gradient.
##' - `proteins_[30 or 60]min_[intensity or iBAQ or LFQ]`: 6 assays
##'   containing protein intensities, iBAQ normalized or LFQ normalized
##'   quantifications (see `References`) for either a 30min or a 60 min
##'   gradient.
##'
##' Sample annotation is stored in `colData(williams2020_lfq())`.
##'
##' @section Acquisition protocol:
##'
##' The data were acquired using the following setup. More information
##' can be found in the source article (see `References`).
##'
##' - **Sample isolation**: cultured MCF10A cells were isolated using
##'   flow-cytometry based cell sorting and deposit on nanoPOTS
##'   microwells
##' - **Sample preparation**: cells are lysed using using a DDM+DTT
##'   lysis buffer. Alkylation was then performed using an IAA solution.
##'   Proteins are digested with Lys-C and trypsin followed by
##'   acidification with FA. Sample droplets are then dried until
##'   LC-MS/MS analysis.
##' - **Liquid chromatography**: peptides are loaded using the new
##'   autosampler described in the paper. Samples are loaded using a
##'   a homemade miniature syringe pump. The samples are then desalted
##'   and concentrated through a SPE column (4cm x 100µm i.d. packed
##'   with 5µm C18) with microflow LC pump. The peptides are then eluted
##'   from a long LC column (60cm x 50 µm i.d. packed with 3µm C18)
##'   coupled to a nanoflox LC pump at 150nL/mL with either a 30 min
##'   or a 60 min gradient.
##' - **Mass spectrometry**: MS/MS was performed on an Orbitrap Fusion
##'   Lumos Tribrid MS coupled to a 2kV ESI. MS1 setup: Orbitrap
##'   analyzer at resolution 120.000, AGC target of 1E6, accumulation
##'   of 246ms. MS2 setup: ion trap with CID at resolution 60.000, AGC
##'   target of 2E4, accumulation of 120ms (50 cells) or 250ms (0-10
##'   cells).
##' - **Raw data processing**: preprocessing using Maxquant v1.6.2.10
##'   that use Andromeda search engine (with UniProtKB 2016-21-29),
##'   MBR and LFQ normalization were enabled.
##'
##' @section Data collection:
##'
##' All data were collected from the MASSIVE repository (accession ID:
##' MSV000085230).
##'
##' The peptide and protein data were extracted from the `Peptides_[...].txt`
##' or `ProteinGroups[...].txt` files, respectively, in the
##' `MCF10A_LC_[30 or 60]minutes` folders.
##'
##' The tables were duplicated so that peptide intensisities, peptide
##' LFQ, protein intensities, protein LFQ and protein intensities are
##' contained in separate tables. Tables are then converted to
##' [SingleCellExperiment] objects. Sample annotations were infered
##' from the sample names and from the paper. All data is combined in
##' a [QFeatures] object. [AssayLinks] were stored between peptide
##' assays and their corresponding proteins assays based on the
##' leading razor protein (hence only unique peptides are linked to
##' proteins).
##'
##' The script to reproduce the `QFeatures` object is available at
##' `system.file("scripts", "make-data_williams2020_lfq.R", package = "scpdata")`
##'
##' @section Suggestion:
##'
##' See `QFeatures::joinAssays` if you want to join the 30min and
##' 60min assays in a single assay for an integrated analysis.
##'
##' @source
##'
##' The PSM and protein data can be downloaded from the MASSIVE
##' repository MSV000085230.
##'
##' @references
##'
##' **Source article**: Williams, Sarah M., Andrey V. Liyu, Chia-Feng
##' Tsai, Ronald J. Moore, Daniel J. Orton, William B. Chrisler,
##' Matthew J. Gaffrey, et al. 2020. “Automated Coupling of
##' Nanodroplet Sample Preparation with Liquid Chromatography-Mass
##' Spectrometry for High-Throughput Single-Cell Proteomics.”
##' Analytical Chemistry 92 (15): 10588–96.
##' ([link to article](http://dx.doi.org/10.1021/acs.analchem.0c01551)).
##'
##' **LFQ normalization**: Cox, Jürgen, Marco Y. Hein, Christian A. Luber,
##' Igor Paron, Nagarjuna Nagaraj, and Matthias Mann. 2014. “Accurate
##' Proteome-Wide Label-Free Quantification by Delayed Normalization
##' and Maximal Peptide Ratio Extraction, Termed MaxLFQ.” Molecular
##' & Cellular Proteomics: MCP 13 (9): 2513–26.
##' ([link to article](http://dx.doi.org/10.1074/mcp.M113.031591)).
##'
##' **iBAQ normalization**: Schwanhäusser, Björn, Dorothea Busse, Na
##' Li, Gunnar Dittmar, Johannes Schuchhardt, Jana Wolf, Wei Chen, and
##' Matthias Selbach. 2011. “Global Quantification of Mammalian Gene
##' Expression Control.” Nature 473 (7347): 337–42.
##' ([link to article](http://dx.doi.org/10.1038/nature10098)).
##'
##' @examples
##' \donttest{
##' williams2020_lfq()
##' }
##'
##' @keywords datasets
##'
"williams2020_lfq"
