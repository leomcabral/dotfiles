#!/bin/env bash

SCRIPT_NAME="Image-add_drop_shadow"

while IFS= read -r file; do

  # skip last newline
  if [ -z "$file" ]; then
    continue
  fi

  if [ -z "$(file "$file" | grep "PNG image data")" ]; then
    # skip files that are not png
    echo "Skipping ${file}"
    continue
  else
    INPUT_FILENAME="${file}"
    OUTPUT_FILENAME="${INPUT_FILENAME/\.png/_shadow.png}"

    convert "${INPUT_FILENAME}" \( +clone -background black -shadow 50x10+15+15 \) +swap -background none -layers merge +repage "${OUTPUT_FILENAME}"

    echo "Shadow applied. ${INPUT_FILENAME} => ${OUTPUT_FILENAME}"
  fi
  
done <<< "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"

