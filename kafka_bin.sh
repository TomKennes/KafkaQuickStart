# Aliases
alias zoostart='sudo $kafkadir/kafka_$kafkaversion/bin/zookeeper-server-start.sh $kafkadir/kafka_$kafkaversion/config/zookeeper.properties'
alias kafkastart='sudo $kafkadir/kafka_$kafkaversion/bin/kafka-server-start.sh $kafkadir/kafka_$kafkaversion/config/server.properties'
alias getIP="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# functions
function kafkatopic() {
    port=${2:-2181}
    echo "Port:"$port
    topic=${1:-"hello kafka"}
    echo "Topic:"$topic
    echo ""
    $kafkadir/kafka_$kafkaversion/bin/kafka-topics.sh --create --zookeeper localhost:$port --replication-factor 1 --partitions 1 --topic $topic
}

function kafkaListTopics(){
    port=${1:-2181}
    echo "Port:"$port
    echo ""
    $kafkadir/kafka_$kafkaversion/bin/kafka-topics.sh --list --zookeeper localhost:$port
}

function kafkaConsoleProd(){
    port=${2:-9092}
    echo "Port:"$port
    topic=${1:-"hello kafka"}
    echo "Topic:"$topic
    echo ""
    $kafkadir/kafka_$kafkaversion/bin/kafka-console-producer.sh --broker-list localhost:$port -topic $topic
}

function kafkaConsoleCon(){
    port=${2:-2181}
    echo "Port:"$port
    topic=${1:-"hello kafka"}
    echo "Topic:"$topic
    echo ""
    $kafkadir/kafka_$kafkaversion/bin/kafka-console-consumer.sh --zookeeper localhost:$port -topic $topic --from-beginning

}

function portActivity(){
    port=${1:-2181}
    echo "Port:"$port
    echo ""
    echo dump | nc localhost $port 
}

function kafkaTopicPartitionChange(){
    port=${2:-2181}
    echo "Port:"$port
    topic=${1:-"Hello kafka"}
    echo "Topic:"$topic
    if [ -z "$3" ]
      then
        echo "No partition argument supplied";
      else 
        partitions=$3
        echo ""
        $kafkadir/kafka_$kafkaversion/bin/kafka-topics.sh -zookeeper localhost:2181 --alter --topic MultiBrokerApplication --partitions $partitions;
    fi  
}

function kafkaBrokers(){
    portActivity | grep brokers
}

function kafkaTopicInfo(){
    port=${2:-2181}
    echo "Port:"$port
    topic=${1:-"hello kafka"}
    echo "Topic:"$topic
    echo "'"
    $kafkadir/kafka_$kafkaversion/bin/kafka-topics.sh --describe --zookeeper localhost:$port --topic $topic
}

function kafkaTopicDelete(){
    port=${2:-2181}
    echo "Port:"$port
    topic=${1:-"hello kafka"}
    echo "Topic:"$topic
    echo ""
    $kafkadir/kafka_$kafkaversion/bin/kafka-topics.sh --zookeeper localhost:$port --delete --topic $topic
}

