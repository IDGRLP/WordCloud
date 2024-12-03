# -----------------------------------------------------------------------------------------------------------------------
# Erstellung einer Wordcloud für Substanznamen
# SST KKN 
# 11.2024
#
# Quellen:
# https://plotly.com/ggplot2/treemaps/
#
# -----------------------------------------------------------------------------------------------------------------------

# 0. Pfade und Pakete ---------------------------------------------------------------------------------------------------

# Daten
dir_dat <- file.path("G:", "2_Registerbereich", "2.2_Auswertung", "01_Rohdaten", "ZfKD_Lieferdatensatz", "2024", "20241022")

# Ergebnisse
dir_erg

# Pakete
dir_packages <- file.path("G:", "2_Registerbereich", "2.2_Auswertung", "_R_Project", "_R_Packages_433")

.libPaths(dir_packages)
.libPaths()

library(RColorBrewer)
library(wordcloud)
library(summarytools)
library(tidyverse)


# 1. Daten ---------------------------------------------------------------------------------------------------------------

# Tabelle Substanz der ZfKD-Daten einlesen
ZfKD_Substanz <- readRDS(file.path(dir_dat, "Substanz.rds")) 
colnames(ZfKD_Substanz)
summarytools::freq(ZfKD_Substanz$TypeOfSYST_TypSubstanz)

ZfKD_Substanz1 <- ZfKD_Substanz |>
  dplyr::filter(TypeOfSYST_TypSubstanz == "Bezeichnung") |>
  dplyr::group_by(Bezeichnung) |>
  dplyr::summarize(Anzahl = n()) |>
  dplyr::arrange(desc(Anzahl)) 


# Anzeige ColorBrewer Farbpaletten
display.brewer.all()

# 2. Abbildung ---------------------------------------------------------------------------------------------------------------

# Zufällige Anordnung der Substanznamen in der Grafik, kann mit der Angabe eines Start-Wertes unterbunden werden
set.seed(10)

# Erstellung der Abbildung
wordcloud(words = ZfKD_Substanz1$Bezeichnung,
          freq = ZfKD_Substanz1$Anzahl, 
          min.freq = 1,           
          max.words = 100, 
          random.order = FALSE, 
          rot.per = 0.35,            
          colors = brewer.pal(8, "Dark2"))




# Alternativ Verwendung einer eigenen Farbpalette
palette_kkn_hex <- c("#82A287", "#CCE9CC", "#11843A", "#1ACC5A", "#67EB96", "#4C6410", "#94C11F", "#2D95D3")

# Zufällige Anordnung der Substanznamen in der Grafik, kann mit der Angabe eines Start-Wertes unterbunden werden
set.seed(50)

# Erstellung der Abbildung
wordcloud(words = ZfKD_Substanz1$Bezeichnung,
          freq = ZfKD_Substanz1$Anzahl, 
          min.freq = 1,           
          max.words = 100, 
          random.order = FALSE, 
          rot.per = 0.35,            
          colors = palette_kkn_hex)

