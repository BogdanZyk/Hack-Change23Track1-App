.PHONY: push

start:
	# docker build -t audio-stream .
	# --network=host  
	docker run --rm \
	-v ./public/:/app/public \
	-v ./static/:/app/static \
	-v ./content/:/app/content \
	-v ./migrations/:/app/migrations \
	-v ./data.db/:/app/data.db \
	--net testnet --ip 192.168.1.10 \
	--name audio-stream-service \
	audio-stream

run: 
	docker compose up -d --build

push:
	GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_gitlab" git push

build:
	go build -o audio-stream

release:
	tar --exclude='./.git'  --exclude='./data.db' -zvcf ./audio-stream.tgz .

convert:
	ffmpeg -i $INPUT_FILE -c:a libopus -page_duration 20000 -vn output.ogg


deploy:
	tar --exclude='./.git' --exclude='./audio-stream' --exclude='./data.db' -zvcf ./audio-stream.tgz .
	scp ./audio-stream.tgz root@45.12.237.146:/root/app
	ssh root@45.12.237.146 -C "\
        source ~/.profile && \
        cd /root/app && \
        find . -not -name '*.tgz' -not -name '*.db' -delete && \
        tar -xzf audio-stream.tgz && \
        go build -o audio-stream && \
		cp ./audio-stream.service /lib/systemd/system/audio-stream.service && \
		systemctl daemon-reload && \
		systemctl restart audio-stream.service"


	    # docker compose build && \
        # docker compose up -d"

create-service:
	cp ./audio-stream.service /lib/systemd/system/audio-stream.service
