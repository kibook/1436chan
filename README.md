This file pertains to the Github repository of 1436chan, for general information see README.

# 1436chan home
gopher://khzae.net/1/chan

http://khzae.net/1/chan (via [Bucky](https://github.com/kibook/bucky))


# Installing (via github)

1. cd to a directory on your Gopher server

    ```
    /# cd /var/gopher
    ```

2. clone this repository to the subdirectory where your chan will be deployed

    ```
    /var/gopher# git clone https://github.com/kibook/1436chan.git chan
    ```
		
3. cd in to the cloned folder

    ```
    /var/gopher# cd chan
    ```

4. Run setup.sh to configure your chan

    ```
    /var/gopher/chan# sh setup.sh
    ```

# Upgrading (via github)

1. cd to the directory where your chan is deployed

    ```
    /# cd /var/gopher/chan
    ```

2. pull the latest version of the repository

    ```
    /var/gopher/chan# git pull origin master
    ```

3. Run setup.sh

    ```
    /var/gopher/chan# sh setup.sh
    ```

 You can use the -quick flag with setup.sh to skip the prompts and select all defaults. When upgrading, setup.sh will use
 your current configuration as the defaults.

 ```
 /var/gopher/chan# sh setup.sh -quick
 ```

