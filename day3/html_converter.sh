#!/bin/bash
rm notebooks/*.html
docker exec -it notebook jupyter nbconvert --to html work/\*.ipynb
mv notebooks/*.html notebooks/html
