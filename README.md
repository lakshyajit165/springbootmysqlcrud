# springbootmysqlcrud
> A CRUD app with spring boot and mysql to test running with docker

## Notes
- It turns out that the **mysql** image from dockerhub gives some error with setting up passwords and other connection errors with spring boot
- So use the **mysql-server** image instead (refer [here](https://hub.docker.com/r/mysql/mysql-server/))

## Detailed Steps
- Run the image with port mapping ```docker run --name=mysqldb -p 3308:3306 -d mysql/mysql-server:latest```
- Wait a little so that the container is fully running, before generating the initial password
- Change the password: 
  - ```docker logs mysqldb 2>&1 | grep GENERATED``` and then 
  - ```docker exec -it mysqldb mysql -uroot -p```
  - mysql>```ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';``` Now the password for the root user is changed to root.
- Now we have 2 options, either change the host field of the root user to '%' or create a new user and follow the same steps as above and then modify the host field.
  - **For a new user:** mysql>```CREATE USER 'gagool'@'%' IDENTIFIED BY 'gagool';``` and then ```grant all on *.* to 'gagool'@'%';```
  - **Modifying the root user:** mysql>```update mysql.user set host='%' where user='root';```
  
## Refer the screenshots here:
![Screenshot from 2020-05-02 21-12-44](https://user-images.githubusercontent.com/30868587/80868941-1ce89900-8cbb-11ea-8267-e8d7083d0611.png)

![Screenshot from 2020-05-02 21-12-37](https://user-images.githubusercontent.com/30868587/80868947-2540d400-8cbb-11ea-90e6-b860dd9c0eee.png)

![Screenshot from 2020-05-02 20-53-00](https://user-images.githubusercontent.com/30868587/80868955-2a9e1e80-8cbb-11ea-8821-35945563a3f6.png)

![Screenshot from 2020-05-02 20-52-45](https://user-images.githubusercontent.com/30868587/80868957-31c52c80-8cbb-11ea-8bc7-cd3de8a9aeb2.png)

![Screenshot from 2020-05-02 21-31-58](https://user-images.githubusercontent.com/30868587/80869164-62f22c80-8cbc-11ea-8864-728411f06c3d.png)


