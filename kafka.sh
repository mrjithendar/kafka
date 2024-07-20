#More Details: https://www.conduktor.io/kafka/starting-kafka/
releaseDate=$(curl -s https://kafka.apache.org/downloads | grep Released | head -1 | xargs)
downloadLink=$(curl -s https://kafka.apache.org/downloads | grep Scala | sed -n '2 p' | sed -e 's|<| |g' -e 's|>| |g' | xargs -n1 | grep href | grep ".tgz" | head -1 | sed -e 's|href=||g')
VERSION=$(echo -e $downloadLink | tr "/" "\n" | tail -1 | sed -e 's|.tgz||g')
USER=$(whoami)

echo version: $VERSION, released on: $releaseDate, and url: $downloadLink

if [ -d "/Users/$USER/$VERSION" ]; then
    echo "Directory: ~/$VERSION does exist."
    else
    echo "Directory: ~/$VERSION does not exist, downloading Kafka"
    curl -L $downloadLink -o /tmp/$VERSION.tgz
    tar -xzf /tmp/$VERSION.tgz --directory ~/
fi

check=$(cat ~/.bash_profile | grep kafka)
if [ $? -ne 0 ]; then
    echo "PATH="'$PATH':/Users/$USER/$VERSION/bin"" >> ~/.bash_profile
    source ~/.bash_profile
    echo "$VERSION updated in ~/.bash_profile"
    else
    echo "$VERSION already updated"
fi

# zookeeper-server-start.sh ~/kafka_2.13-3.7.1/config/zookeeper.properties
# kafka-server-start.sh ~/kafka_2.13-3.7.1/config/server.properties

# kafka-topics.sh --bootstrap-server localhost:9092 --list


# Kafka in KRaft mode No ZooKeeper Required
# UUID=$(kafka-storage.sh random-uuid) || true && echo $UUID #txio5rPxTo6XSZMp_YvvnQ
# kafka-storage.sh format -t Ft624PWNT1evJBf6wYAIyg -c ~/kafka_2.13-3.7.1/config/kraft/server.properties
# kafka-server-start.sh ~/kafka_*/config/kraft/server.properties


# kafka-storage.sh format -t <uuid> -c ~/kafka_2.13-3.0.0/config/kraft/server.properties

