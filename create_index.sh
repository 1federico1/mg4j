#!/bin/bash

# set CLASSPATH

source set-my-classpath.sh

# Building the collection of documents
# Create the collection

echo "choose the collection folder"
read collection

to_append=".collection"

collection_file="$collection$to_append"

html_factory="it.unimi.di.big.mg4j.document.FileSetDocumentCollection -f HtmlDocumentFactory -p encoding=UTF-8 $collection_file"

echo "Creating the collection"

find $collection -iname \*.html | java $html_factory

#Create the index
# no memory optimization (-Xmx)

echo "Creating the index. It may require some time"

build_index="it.unimi.di.big.mg4j.tool.IndexBuilder --downcase -S $collection_file $collection"

java $build_index 

#Querying the index

text="-text"
title="-title"
coltext=$collection$text
coltitle=$collection$title

echo "Now you can query the index you just built! You can use the console or go to http://localhost:4242/Query from
your browser"

query_index="it.unimi.di.big.mg4j.query.Query -h -i FileSystemItem -c $collection_file $coltext $coltitle"
java $query_index
