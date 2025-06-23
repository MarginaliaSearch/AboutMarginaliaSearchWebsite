#!/bin/bash

hugo 
npm install tailwindcss@3
npx tailwindcss -o static/css/style.css
