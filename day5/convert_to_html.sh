#!/bin/bash
rm notebooks/*.html
docker exec notebook jupyter nbconvert --to html work/lgde-\*.ipynb
mv notebooks/lgde-basic-*.html notebooks/html
