require(ggplot2)
require(dplyr)
require(sf)
require(ggimage)

delta<-read_sf("~/ds586/ds586.gdb")%>%
    mutate(Shape=st_cast(Shape, "POLYGON"))

coords<-st_coordinates(deltamapr::WW_Delta)

d <- #st_sample(delta, 300)%>%
    st_make_grid(delta, n=c(20,20), square=F, what="centers", flat_topped=T)%>%
    st_coordinates()%>%
    as_tibble()%>%
    mutate(icon=sample(c('bed', 'fast-food', 'bus', 
                         'business', 'book', 'call', 
                         'ice-cream', 'mail-unread', 'musical-notes', 
                         'flask', 'language', 'pizza', 
                         'beer', 'walk' ,'bed'), size=nrow(.), replace=T))

ggplot()+
    geom_icon(data=d, aes(x=X, y=Y, image=icon), color="chartreuse1")+
    #geom_sf(data=deltamapr::WW_Delta, color="dodgerblue4", fill="dodgerblue1", alpha=0.8)+
    geom_sf(data=delta, color="white", fill=NA)+
    theme_void()+
    theme(plot.background=element_rect(fill="black"))
