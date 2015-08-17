#!/usr/bin/env zsh
PPATH=$1
PTITLE=$2
if [[ -z $PPATH || -z $PTITLE ]]; then
  # Allow ASK=1 usage from Makefile
  if [[ -z $ASK ]]; then
    echo "USAGE: $0 [path] [title]"
    exit 1
  fi

  echo -n "TITLE: "
  read PTITLE
  # If tree is installed then show existing post paths
  /usr/bin/which -s tree
  if [[ $? -eq 0 ]]; then
    echo "\n\nListing existing post paths:"
    tree -d -L 2 content
  fi
  echo -n "PATH: "
  read PPATH

  # If they still didn't specify then bail
  if [[ -z $PPATH || -z $PTITLE ]]; then
    exit 1
  fi
fi

# Path Cleanup, remove content and post if they are at the start of the path
PPATH=${PPATH#content/}
PPATH=${PPATH#post/}

# Check that the destination path does actually exist
DPATH="content/post/${PPATH}"
if [[ ! -d $DPATH ]]; then
  echo "ERROR: $DPATH does not exist!"
  echo -n "\nType 'yes' to create it: "
  read ASKYN
  if [ "$ASKYN" = "yes" ]; then
    md -p $DPATH
  else
    echo "Exiting"
    exit 1
  fi
fi
# remove content/ that is added by hugo
DPATH=${DPATH#content/}

# Remove spaces from title, lowercase the filename
PTITLE=${PTITLE// /_}
PTITLE=${(L)PTITLE}

# Build new path, date prefixed
DPREFIX=$(date '+%Y-%m%d')
DPATH="${DPATH}/${DPREFIX}-${PTITLE}.md"

echo "hugo new $DPATH"
hugo new $DPATH
