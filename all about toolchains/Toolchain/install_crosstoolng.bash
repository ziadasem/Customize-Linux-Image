#!/bin/bash

#################################### Functions ###################################

#pre: current working directory is not set to the workspace directory
#post move to the workspace directory, and create if not exist
makeworkspace(){
    mkdir ~/$1
    echo "Moving to the directory $dir_name"
    cd ~/$dir_name

}

#pre: the current dir should be the workspace
#post: clone crosstool-ng repo with 1.26.0 branch
downloadstablect-ng(){
    echo "clone the repository, make sure you have a stable network connection"
    git clone https://github.com/crosstool-ng/crosstool-ng.git 
    cd crosstool-ng

    echo "checkout to a stable release"
    git checkout crosstool-ng-1.26.0
} 

#pre: the current dir should be the ct-ng directory
#post: cbuild files are generated and ct-ng is ready to use
install_ctng(){
    echo "Installing, in case of failure  at this stage rerun the script with sudo and argument -l to prevent redownloading"
    cd ~/$1/crosstool-ng
    ./bootstrap
    ./configure --prefix=${PWD} --enable-local #run the configure script
    make
    make install #in case of failure run with sudo make install  
}



dir_name=""
mode="full"
while getopts d:l: flag
do
    case "${flag}" in
        d) dir_name="${OPTARG}"
        ;;
        l)mode="install"
        ;;
        *) echo "Invalid option, -d for setting the directory and -m install in case you don't want to download" >&2; exit 1
        ;;
    esac
done
if [[ $dir_name == "" ]]; then
    echo "please enter a directory name to install the toolchain in"
    exit -1
fi

if [[ $mode != "install" ]]; then
makeworkspace "$dir_name"
downloadstablect-ng
fi
install_ctng "$dir_name"