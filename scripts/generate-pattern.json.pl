#!/usr/bin/env -S perl -n
BEGIN {
    print '{';
}

END {
    print '    ".": ""' . "\n}";
}
if (/^const DIRECTORY_ICONS:/) {
    $is_enabled = 1;
    next;
}
$is_enabled = 0 if (/^};$/);
next unless $is_enabled;
s|\s*=>.*//\s*|: "|;
s|$|",|;
s|([^"]*)(?=":)|/$1.\$|;
s|\.|\\\\.|;
print $_;
