# Uses PHP 74-fpm.0, as the base image
FROM bref/php-74-fpm


#override values in fpm config
#RUN echo "user = sbx_user1051" >> /opt/bref/etc/php-fpm.conf
RUN echo "user = nobody" >> /opt/bref/etc/php-fpm.conf

# download composer for dependency management
RUN curl -s https://getcomposer.org/installer | php
# install bref using composer
RUN php composer.phar require bref/bref

# copy the project files into a Location that the Lambda service can read from#
#LAMBDA_TASK_ROOT variable is set tot /var/task
COPY ./code/* /var/task

#ENTRYPOINT ["tail", "-f", "/dev/null"]

# lambda-entrypoint.sh script will both set _HANDLER to index.php and launch the Lambda service

#RUN _HANDLER=index.php
ENTRYPOINT ["/lambda-entrypoint.sh", "index.php"]

