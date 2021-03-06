#!/usr/bin/perl - w
use strict;

#=======================
#int to str converter
#=======================

# Converts numbers into words.

# my $sum = 0; # not needed anymore - but leaving it here as a reminder to myself

#main

for (1..1000){
   my @f = arrayfy($_);
   @f = stringify(@f);
   my $stringy_num = join " ", @f;
   $stringy_num =~ s/\d|#//gi;
   $stringy_num =~ s/ and *$//gi;
   my @chars = ($stringy_num =~ m#\w#g );
#   $sum += @chars; # as above
   print "$stringy_num\n";
}

#=======================================================================
#ARRAYFY
#========================================================================

sub arrayfy{

#each digit that compose the number becomes the element of an array, and then the elements are pushed so that units are the last element, tens are the second last element and so forth
#For instance:
# Number: 678
# ==> becomes @arr, where |6|7|8|
# as $arr[3] is undef (since is less than 1000, so it's only 4 digits), the second part of the function unshifts the elements by one
# so : ===> |#|6|7|8|
# now the array is ready to be stringified! :-)
   
   (my $str) = @_;
   my @arr = split '', $str;
#   print STDERR ">|$arr[0]|$arr[1]|$arr[2]|$arr[3]|   ###>  ";
   my $zeroes = (!defined $arr[1]) ? 2 : (!defined $arr[2]) ? 1 : 0; 
   
   unless (defined $arr[3]){
      for (0..$zeroes){
         unshift @arr, '#'; 
      }
   }
#   print STDERR "|$arr[0]|$arr[1]|$arr[2]|$arr[3]|\n";
   return @arr;
}

#========================================================================
#STRINGIFY
#=========================================================================
sub stringify{
   my $pos = {un => ,dec =>,ten =>};

   $pos->{un} = {
      1 => 'one',
      2 => 'two',
      3 => 'three',
      4 => 'four',
      5 => 'five',
      6 => 'six',
      7 => 'seven',
      8 => 'eight',
      9 => 'nine',
      };

   $pos->{dec} = {
      1 => 'ten',
      2 => 'twenty',
      3 => 'thirty',
      4 => 'fourty',
      5 => 'fifty',
      6 => 'sixty',
      7 => 'seventy',
      8 => 'eighty',
      9 => 'ninety',
      };

   $pos->{ten} = {
      0 => 'ten',
      1 => 'eleven',
      2 => 'twelve',
      3 => 'thirteen',
      4 => 'fourteen',
      5 => 'fifteen',
      6 => 'sixteen',
      7 => 'seventeen',
      8 => 'eighteen',
      9 => 'nineteen',
      };
#tens
   if ($_[2] == 1){
      $_[2] = $pos->{ten}{$_[3]};
      pop @_;
      }
   
   else{  
      #unita'
      $_[3] = $pos->{un}{$_[3]};
      #decine
         $_[2] = $pos->{dec}{$_[2]};
}
 
   #centinaia
   $_[1] = $pos->{un}{$_[1]}." hundred and" unless ($_[1] == '');
   
   #migliaia
   $_[0] = $pos->{un}{$_[0]}." thousand" unless ($_[0] == '');
   return @_;
}

