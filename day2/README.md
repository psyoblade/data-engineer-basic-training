# 


```bash
bash> docker-compose up -d
Creating network "default_network" with the default driver
Creating mysql ... done
Creating sqoop ... done

bash> docker-compose ps
Name              Command                State                                                                              Ports
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
mysql   docker-entrypoint.sh mysqld   Up (healthy)   0.0.0.0:3306->3306/tcp, 33060/tcp
sqoop   /etc/bootstrap.sh -d          Up             0.0.0.0:10020->10020/tcp, 0.0.0.0:19888->19888/tcp, 2122/tcp, 49707/tcp, 50010/tcp, 50020/tcp, 0.0.0.0:50070->50070/tcp, 0.0.0.0:50075->50075/tcp,
                                                     50090/tcp, 8020/tcp, 8030/tcp, 8031/tcp, 8032/tcp, 8033/tcp, 8040/tcp, 8042/tcp, 0.0.0.0:8088->8088/tcp, 9000/tcp

bash> docker-compose exec sqoop bash


#> ./tutorials.sh
sqoop import -jt local -m 1 --driver com.mysql.jdbc.Driver --connect jdbc:mysql://mysql:3306/testdb --table seoul_popular_trip --target-dir file:///home/sqoop/target/seoul_popular_trip/default --verbose --username sqoop --password sqoop --relaxed-isolation

#> ls -al /home/sqoop/target/seoul_popular_trip/default

#> head -1 /home/sqoop/target/seoul_popular_trip/default/part-m-00000
0,281,통인시장,110-043 서울 종로구 통인동 10-3 ,03036 서울 종로구 자하문로15길 18 ,02-722-0911,엽전도시락,종로통인시장,통인시장닭꼬치,런닝맨,엽전시장,통인시장데이트,효자베이커리,통인시장, 1박2일,기름떡볶이

#> # --as-parquetfile
#> sqoop import -jt local -m 1 --driver com.mysql.jdbc.Driver --connect jdbc:mysql://mysql:3306/testdb --table seoul_popular_trip --target-dir file:///home/sqoop/target/seoul_popular_trip/parquet --verbose --username sqoop --password sqoop --relaxed-isolation --as-parquetfile
#> java -version
openjdk version "1.8.0_262"
OpenJDK Runtime Environment (build 1.8.0_262-b10)
OpenJDK 64-Bit Server VM (build 25.262-b10, mixed mode)

#> cat /etc/centos-release
#> yum check-update
#> yum install -y git maven

#> hadoop jar /jdbc/parquet-tools-1.8.1.jar head file:///home/sqoop/target/seoul_popular_trip/<TAB>/<TAB>

#> exit

bash> docker-compose down
```
