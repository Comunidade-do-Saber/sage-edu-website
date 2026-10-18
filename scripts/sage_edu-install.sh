#!/bin/bash

echo "🏫 SAGE Education - Institutional Management"
echo "Version: 2.0.x"
echo "Module: AMS, SMS & EIS"  
echo "Author: Zacarias Juliano Capingala *Família Pequenino Capingala*"

echo "🚀 Install SAGE Edu..."
# -----------------------------
# 1. Install Dependencies
# -----------------------------
echo "📦 Install Dependencies"
sudo apt update && upgrade
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl \
    libreoffice


# -----------------------------
# 2. Install PostgreSQL
# -----------------------------
echo "📦 Install PostgreSQL"
sudo apt install -y postgresql postgresql-contrib

echo "👤 Create de user profile and the data base"

sudo -u postgres createuser -s sage_education
sudo -u postgres psql -c "ALTER ROLE sage_education WITH PASSWORD 'sage_education';"
sudo -u postgres psql -c "DROP DATABASE comunidadedosaber;"
sudo -u postgres psql -c "CREATE DATABASE comunidadedosaber WITH ENCODING 'UTF8' TEMPLATE template1;"


# -----------------------------
# 3. Install Python + Config Virtualenv
# -----------------------------
echo "🐍 Install Python + Config Virtualenv"
sudo apt install -y python3 python3-venv python3-pip

cd ~
python3 -m venv sage_education
cd ~/sage_education
source ./bin/activate


# -----------------------------
# 4. Install SAGE Edu
# -----------------------------
echo "📚 Install SAGE Edu Modules"
pip install --upgrade pip
pip install psycopg-binary
pip install psycopg_pool
pip install psycopg
pip install psycopg2
pip install pyproject-toml
pip install pycountry
pip install pycurrency
pip install proteus==8.0.0
pip install trytond==8.0.0
pip install trytond-currency==8.0.0
pip install trytond-party-avatar==8.0.0
pip install trytond-account-product==8.0.0
pip install trytond-sale==8.0.0
pip install trytond-stock_supply==8.0.0
#pip install trytond-sale==8.0.0
pip install akademy-party~=8.0.0
pip install akademy-company~=8.0.0
pip install akademy-classe~=8.0.0
pip install akademy-classe-evaluation~=8.0.0
#pip install akademy-evaluation~=7.0.1
pip install akademy-matriculation~=8.0.0
pip install akademy-matriculation-confirmation~=8.0.0
pip install akademy-dashboard~=8.0.0


cd ~/sage_education
echo "📝 Create the file configuration trytond.conf..."
cat << EOF > trytond.conf
[database]
uri = postgresql://sage_education:sage_education@localhost:5432/comunidadedosaber

[web]
listen = 0.0.0.0:8000
root = ~/sage_education/frontend

EOF


# --------------------
# 5. Install FrontEnd  
# --------------------
echo "📚 Install Tryton SAO"
wget https://downloads.tryton.org/8.0/tryton-sao-8.0.0.tgz
mkdir frontend
sudo tar -xvzf tryton-sao-8.0.0.tgz
mv package frontend
cd frontend

sudo apt install npm -y
sudo apt install node-grunt-cli
sudo npm install --production --legacy-peer-deps


# -----------------------------
# 6. Inicialize the data base
# -----------------------------
echo "🛠 Install Modules..."
trytond-admin -c trytond.conf -d comunidadedosaber --all
#trytond_import_countries -d 'postgresql://sage_education:5432/comunidadedosaber' -c trytond.conf
#trytond_import_currencies -d 'postgresql://sage_education:5432/comunidadedosaber' -c trytond.conf

echo "🎉 Instalation finish!"
echo "The SAGE Education is running:"
trytond -c trytond.conf
