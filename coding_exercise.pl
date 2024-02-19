#!/usr/bin/perl

## Jeri Dilts
## 01/14/2024

=pod
Explaination:

 This perl script decodes a message from a specific input-file type where each line has a number and an associated word. Three subroutines were created to process and decode the input-file. 
 
 1. The first, capture_file_contents(), opens up a file handle called INPUT and iterates over each line. At each line the data is processed and stored into a hash called %input_file_contents. Once the data has been captured, the file handle, INPUT, is closed and the second subroutine, sort_data(), is called. 

 2. sort_data() sorts the keys of hash %input_file_contents in numerical order with Perl's built in 'sort' function and stores the organized data into an array named @sorted_contents with their corresponding word. 
 
 3. Lastly, subroutine, decode_with_pyramid() is called. Here the sorted array is spliced incrementally with variable step. Perl's splice function is nice because it removes those specified elements from the original array (no additional code required). It had been some time since I had written in Perl and found the language struggling with multi-dimensional arrays. I decided to sweeten the process by skipping the storing of sub-arrays and simply take the last element of what would have been the sub-arrays of @subsets to get the decoded message. This just made more sense to me. 

 Thanks! -Jeri
=cut




use strict;
use warnings;



my $input_file = "./test.txt";
capture_file_contents($input_file);



## place file contents into a hash
sub capture_file_contents {
    my $file = shift; ## unpack argument
    my %input_file_contents; 
    open(INPUT, $input_file) || die $!; ## opens file
    while(<INPUT>){ # iterates over file line by line
        chomp; ## eliminates newline
        my @spl = split('\s', $_); # split line by a single space
        $input_file_contents{$spl[0]} = $spl[1]; ## stuffs hash
    }
    close(INPUT); ## closes file
    sort_data(%input_file_contents);
}



## sort input file data
sub sort_data {
    my (%ifc) = @_; ## a different way to unpack an argument
    my @sorted_contents;
    foreach my $index (sort keys %ifc){
        $sorted_contents[$index-1] = $ifc{$index};
    }
    decode_with_pyramid(@sorted_contents);
}



## create pyramid to decode
sub decode_with_pyramid {
    my (@sc) = @_; ## unpack argument
    my $step = 1;
    #my @subsets;
    while(scalar @sc > 0){
        if(scalar @sc >= $step){
            my @arr = splice(@sc,0,$step); ## (array, offset, length)
            print "$arr[$#arr] "; ## decided against subset route
            #push(@subsets, \@arr); ## pushes array reference into subset array
            $step++;
        } else{
            return (); ## iow 'false' ---> an empty list
        }
    }
    print "\n";
}


