#!/bin/bash
rm notebooks/*.html
docker exec notebook jupyter nbconvert --to html work/data-engineer-training-course\*.ipynb
mv notebooks/data-engineer-training-course*.html notebooks/html
