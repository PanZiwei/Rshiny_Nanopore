function(input, output, session) {
  library(shiny)
  dataInput <- reactive({
    #dataframe creation
    df %>%
      filter(Dataset %in% input$dataset, 
             Chrom %in% input$chrom,
             Strand %in% input$strand,
             Singleton %in% input$singleton,
             Genome_location %in% input$genome_location, 
             CpG_island %in% input$cgi)
  })
  output$table1 <- renderDT({
    DT::datatable(dataInput())
  })
  
  # Reference: https://github.com/romanhaa/cerebroApp/blob/7fb55f08d1cb9611039e9b73f2859f3a61f4fd42/inst/shiny/v1.3/about/server.R
  output[["about"]] <- renderText({
    paste0(
      '<b>Overview</b>
      <br>
      This application is for visualization of methylation calling results at site level from Nanopore sequencing data by
      for multiple calling tools (DeepSignal, Nanopolish, Tombo, DeepMod, Megalodon)  compared to bisulfite sequencing (BS-seq).
      <br/>
      In tool comparison section, only sites that are detected by BS-seq are included.
      <br/>
      The data presented here associated with the publication/preprint in the Citation section.
      <br/>
      <i>Note: 1) All start coordinates in the application are 1-based, not 0-based. </i><br>
      <br>
      <b>Citation</b><br>
      If you used the dataset for your research, please cite the following publication:
      <br>
      Wojciech Rosikiewicz, Yang Liu, Ziwei Pan, Sheng Li,
      A  comprehensive comparison of tools for detecting DNA methylation using Nanoporelong-read sequencing data,
      Genome Biology, btz877, 
      <a href=paperlink title="DOI" target="_blank">
      https://doi.org/xxxx</a><br>
      <br>
      <b>Funding</b><br>
      <br>This study was funded and supported by the Jackson Laboratory.<br>
      <br>
      <b>Contact</b><br>
      <a href="mailto:ziwei.pan@jax.org?subject=Nanopore_tool_issue">ziwei.pan@jax.org</a><br>
      <br>
      <b>License</b><br>
      The application is distributed under the terms of the <a href=https://github.com/romanhaa/Cerebro/blob/master/LICENSE.md title="MIT license" target="_blank">MIT license.</a><br>
      <br>'
    )
  })
  
}
