dev() { cd ~/dev/$1; }

# Autocomplete
_dev() {
    _files -W ~/dev -/;
}
compdef _dev dev
