remotes::install_github(repo = 'genecell/COSGR')

library(COSG)
input_sce = monomacro # Seurat object

input_sce <- SetIdent(input_sce, value = input_sce$MyeCellType)
input_sce <- subset(input_sce, MyeCellType %in% c("C0-Mono_Ly6c2","C1-Mono_Chil3","C2-Mono_Ace","C3-Macro_Mmp12","C4-Macro_Arg1","C5-Macro_Mertk"))
input_sce$MyeCellType <- factor(input_sce$MyeCellType, levels =rev(c("C0-Mono_Ly6c2","C1-Mono_Chil3","C2-Mono_Ace","C3-Macro_Mmp12","C4-Macro_Arg1","C5-Macro_Mertk")), 
       ordered = T)

table(Idents(input_sce))
pro = 'cosg_monomacro_clusters'

marker_cosg_6c <- cosg(
    input_sce,
    groups='all',
    assay='RNA',
    slot='data',
    mu=10,
    n_genes_user=100,
    remove_lowly_expressed=TRUE)
  
save(marker_cosg,file = paste0("4.MonoMacro/",pro,'_marker_cosg.Rdata'))
head(marker_cosg)
  
## Top10 genes
library(dplyr)  
top_10 <- unique(as.character(apply(marker_cosg$names,2,head,10)))
sce.Scale <- ScaleData(input_sce,features = top_5)  
  
sce.Scale$MyeCellType <- factor(sce.Scale$MyeCellType, levels = c("C0-Mono_Ly6c2","C1-Mono_Chil3","C2-Mono_Ace","C3-Macro_Mmp12","C4-Macro_Arg1","C5-Macro_Mertk","C6-Undefined"))
top_5 <- unique(as.character(apply(marker_cosg$names,2,head,5)))

top_5 <- c("Ly6c2","Ms4a4c","Plac8","Slfn5","Oas3",
           "Chil3","Lcn2","Abca6","Mmp8","Vcan",
           "Ace","Vegfc","Eno3","Tgfbr3","S1pr5",
           "Mmp12","Mgl2","Adgrg5","Klrb1b","Pdcd1lg2",
           "Arg1","Rhoc","Mlxipl","Serpine1","Ccl6",
           "Mertk","Slc40a1","Cd5l","Clec4f","Slc16a9"
           )
DoHeatmap(sce.Scale, features = top_5, group.by = "MyeCellType",slot = "scale.data",
          group.colors = c("#5878A3","#E49343","#D1605E","#84B5B3","#6A9F58","#E7CA5F","#A87C9F"),
          label = FALSE) + scale_fill_viridis_b()
              
          
