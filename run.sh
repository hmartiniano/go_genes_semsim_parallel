#!/bin/bash
for ONTOLOGY in BP MF CC
do
  for METHOD in Rel Resnik Wang Lin Jiang
  do
    for COMBINE in max avg rcmax BMA
    do
      sed s,ONTOLOGY,$ONTOLOGY,g GO.R | sed s,METHOD,$METHOD,g | sed s,COMBINE,$COMBINE,g > GO_${ONTOLOGY}_${METHOD}_${COMBINE}.R
      R BATCH --no-save < GO_${ONTOLOGY}_${METHOD}_${COMBINE}.R >& GO_${ONTOLOGY}_${METHOD}_${COMBINE}.log
      gzip GO_${ONTOLOGY}_${METHOD}_${COMBINE}.csv &
    done
  done
done
