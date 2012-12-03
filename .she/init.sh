shell=""
if [ ! -z "$BASH" ]; then
    shell="bash"
elif [ "$ZSH_NAME" = "zsh" ]; then
    shell="zsh"
fi

. "$HOME/.she/vars.sh"

for i in "$HOME/.she/func/"*; do
    . "$i"
done

. "$HOME/.she/aliases.sh"
