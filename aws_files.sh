#!/bin/bash

if [ "$1" == "" ]; then
    echo "Modo de uso: $0 <bucket>"
else
    for path in $(cat path); do
        aws s3 cp s3://$1/$path ./s3_files/ 1> /dev/null
        echo "Arquivo Baixado: $path"
    done
    zip -r s3_files.zip s3_files/ 1> /dev/null
    echo "Zip gerado: s3_files.zip"
    read -p "Quer apagar os arquivos baixados? [y/n]: " -n 1 delete
    echo ""
    if [ "$delete" == "y" ]; then
        for files in $(ls s3_files/); do
            rm s3_files/$files 1> /dev/null
            echo "Arquivo Deletado: $files"
        done
    fi
fi
