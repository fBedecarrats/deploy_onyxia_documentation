#!/bin/sh

# Create variables
WORK_DIR=/home/rstudio/globalforestloss
REPO_URL=https://github.com/mapme-initiative/globalforestloss # As initial

# Git
git clone $REPO_URL $WORK_DIR
chown -R rstudio:users $WORK_DIR

# copy files from S3 
mc cp -r s3/fbedecarrats/diffusion/globalforestloss/data $WORK_DIR

# Again to give ritghs also in the data subfolder 
chown -R rstudio:users $WORK_DIR

# launch RStudio in the right project
# Copied from InseeLab UtilitR
    echo \
    "
    setHook('rstudio.sessionInit', function(newSession) {
        if (newSession && identical(getwd(), path.expand('~')))
        {
            message('On charge directement le bon projet :-) ')
            rstudioapi::openProject('~/globalforestloss')
            rstudioapi::applyTheme('Merbivore')
            }
            }, action = 'append')
            " >> /home/rstudio/.Rprofile
