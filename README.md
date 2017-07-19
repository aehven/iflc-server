# README

Look at the deploy function in setup/webapp.sh.  This function deploys the project to heroku.  The most important part is the way the angular client is built and then copied into the server's public diretory.  This is how we avoid having separate back-end and front-end servers.
