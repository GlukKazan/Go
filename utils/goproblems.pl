#!/usr/bin/perl -w

opendir(H, '.');
while (defined($file = readdir(H))) {
    if ($file =~ /^prob(\d+)\.html?/) {
        print "$file\n";
        my $num = sprintf("%04d", $1);
        my $flag = 0;
        open(F, '<', $file);
        open(O, '>', "$num.sgf");
        while (<F>) {
           if ($flag) {
               if (/^([^\"]+)\">/) {
                  print O "$1\n";
                  $flag = 0;
               } else {
                  print O;
               }
           } else {
               if (/param\s+name=\"sgf\"\s+value=\"(.*)$/) {
                  print O "$1\n";
                  $flag = 1;
               }
           }
        }
        close(O);
        close(F);
    }
}
closedir(H);
