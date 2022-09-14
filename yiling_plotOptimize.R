library(ggplot2)
library(ggthemes)
library(hrbrthemes)
library(cowplot)
library(showtext)
library(extrafont)
font_import(paths = "/usr/share/fonts/truetype/msttcorefonts/")
loadfonts(device = "all")

 # scale_colour_excel_new()
 # scale_color_tableau(palette = "Tableau 10")
 # scale_color_tableau(palette = "Tableau 20")
  
DimPlot(GSE123813.bcc.seu, reduction = "umap", group.by = "Anno") + 
  labs(x = "UMAP_1", y = "UMAP_2", title = "GSE123813 CellType") + 
  theme_ipsum(base_family = "Arial") + 
  theme(
    plot.title = element_text(size=12),
    panel.border = element_rect(fill = NA, size = 0.4)
  )
  
FeaturePlot(GSE123813.bcc.seu, features = "CXCL8") +
  labs(x = "UMAP_1", y = "UMAP_2", title = "GSE123813 CXCL8 Expression") + 
  theme_ipsum(base_family = "Arial") + 
  theme(
    legend.position="none",
    plot.title = element_text(size=12),
    panel.border = element_rect(fill = NA, size = 0.4)
  )
