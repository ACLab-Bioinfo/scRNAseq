library(ggplot2)
library(scales)
meta <- integrated.cluster@meta.data
meta$Status <- factor(meta$Status, levels = c("ERM","PDR PBMC","Health PBMC"), labels = c("FVM","PDR PBMC","Health PBMC"))
meta$seurat_clusters <- factor(meta$seurat_clusters, levels = c("3","5","7","12","15","22","6","8","17","18","10","16","4","13","0","1","2","9","19","11","14","20","21")) # 排序
p <- ggplot(data = meta, aes(x = seurat_clusters, y = nCount_SCT, fill = Status)) + 
  theme_minimal() + 
  geom_bar(stat= 'identity', position = 'fill',width = 0.7)+ #堆叠图，position = fill 表示堆叠图
  labs(x = 'Seurat Clusters',y = 'Relative Abundance',fill = NULL)+ #定义坐标轴以及图例标题
  scale_fill_manual('Status', values=c('#FDBE83', '#C8A3B5', '#2F4E86')) + 
  scale_y_continuous(labels = percent)+
  guides(fill = guide_legend(ncol = 1, bycol = TRUE, override.aes = list(size = 5))) +
  theme(axis.title.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8,vjust = 0.5), #x轴标签偏转45°，并下降0.5
        panel.grid = element_blank(),
      legend.key.height = unit(0.6,'cm')
  )

ggsave(p, filename = 'mono-stack.png', width = 12, height = 6, dpi = 300)
