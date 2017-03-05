# ------------------------------------
# Docker alias and function
# ------------------------------------
#
function dhelp() 
{
    echo "dalias=Show all related docker"
    echo "dbash=Bash into running container"
    echo "dbu=Dockerfile build, e.g., $dbu tcnksm/test "
    echo "dhelp=this message"
    echo "di= Get images"
    echo "dip= Get container IP"
    echo "dkd=Run deamonized container, e.g., $dkd base /bin/echo hello"
    echo "dki= Execute interactive container, e.g., $dex base /bin/bash"
    echo "dki= Run interactive container, e.g., $dki base /bin/bash"
    echo "dl=Get latest container ID"
    echo "dpa=Get process included stop container"
    echo "dps=Get container process"
    echo "dri=Remove all images"
    echo "drm=Remove all containers"
    echo "drmf=Stop and Remove all containers"
    echo "drmsc=Remove all exited containers"
    echo "dstop=Stop all containers"

}

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# Remove all exited containers
alias drmsc='docker rm -v $(docker ps -a -q -f status=exited)'
