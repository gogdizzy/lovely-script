#!/user/bin/perl
use strict;
use warnings;
my %hash;
my %hash_id;
my %hash_output;
unless(@ARGV==1){print STDERR "Usage: perl $0 input.bed \n";exit(-1);}
else{open(ONE,"$ARGV[0]");}
my ($value);
while(<ONE>){
    chomp;
    next if (/^VARIANT/);
    my @aa=split "\t";
    my $id=$aa[6];
    my $gene=$aa[25];
    if (exists $hash{$gene}){
        $hash{$gene}.=";$id";
    }
    else{
        $hash{$gene}=$id;
    }
    if (exists $hash_id{$id}){
        $hash_id{$id}.=";$gene";
    }
    else{
        $hash_id{$id}=$gene;
    }
}

foreach my $id (keys %hash_id) {
    my @gene_names = split ";",$hash_id{$id};
    my @common_ids;
    foreach my $gene_name (@gene_names) {
        my @ids=split ";",$hash{$gene_name};
        if (@common_ids == 0) { @common_ids = @ids; }
        else {
            my %hash_temp = map{$_=>1} @common_ids;
            @common_ids = grep {$hash_temp{$_}} @ids;
        }
    }

    if( @common_ids > 1 ) {
printf STDOUT "%s %s\n", $id, join( ";", @common_ids );
        foreach my $sample (@common_ids) {
            $hash_output{$sample} = 1;
            if( $sample ne $id ) {
                # gene count equal
                my @a1 = split ";",$hash_id{$id}; my $len1 = @a1;
                my @a2 = split ";",$hash_id{$sample}; my $len2 = @a2;
                if( $len1 == $len2 ) {
                    if( $id lt $sample ) {
                        printf STDERR "%s (%s) -> %s (%s)\n", $id, $hash_id{$id}, $sample, $hash_id{$sample};
                    }
                }
                else {
                    printf STDERR "%s (%s) -> %s (%s)\n", $id, $hash_id{$id}, $sample, $hash_id{$sample};
                }
            }
        }
    }
}

