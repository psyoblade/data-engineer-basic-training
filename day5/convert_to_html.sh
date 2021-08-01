#!/bin/bash
rm notebooks/*.html
docker exec notebook jupyter nbconvert work/data-engineer-training-course-answer.ipynb --to html
docker exec notebook jupyter nbconvert work/data-engineer-training-course.ipynb --to html
mv notebooks/*.html notebooks/html
