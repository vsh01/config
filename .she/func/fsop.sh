2h() {
    mv $@ .
}

2hl() {
    ln $@ .
}

2hc() {
    cp $@ .
}

lns() {
    ln -s "`pwd`"/"$1" "$2"
}
