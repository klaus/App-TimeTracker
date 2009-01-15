package App::TimeTracker::Task;

use 5.010;
use warnings;
use strict;

=head1 NAME

App::TimeTracker::Task - interface to one task

=head1 SYNOPSIS

    my $task = App::TimeTracker::Task->new({
        start   => '1232010055',
        project => 'TimeTracker',
        tags    => \@tags,
    });
    $task->stop_it;
    $task->write( '/path/to/basedir' );  


    my $task = App::TimeTracker::Task->read('/path/to/file');
    say $task->start;       # epoche
    say $task->is_active;   # 1 or 0
    say $task->duration;    # in seconds

=cut

use DateTime;
use DateTime::Format::Strptime;
use File::Spec::Functions qw(splitpath catfile catdir);
use File::HomeDir;
use File::Path;
use App::TimeTracker::Exceptions;

__PACKAGE__->mk_accessors(qw(start stop project tags active _path));

=head1 METHODS

=cut

=head3 new

    my $task = App::TimeTracker::App->new( $data );

Initiate a new task object. Provided by Class::Accessor

=cut

=head3 stop_it

    $self->stop_it;
    $self->stop_it( $epoche );

Stop this task, either at the specified C<$epoche>, or C<now()>. Throws an exception if the task is already stopped.

Returns C<$self> for method chaining.

=cut

sub stop_it {
    die "not implemented yet";
}

=head3 read

    my $task = App::TimeTracker::Task->read( $path );

Reads the specified file, parses it, generates a new object and returns the object.

=cut

sub read { 
    my ($class, $path)=@_;

    ATTX::File->throw("Cannot find file $file") unless -r $path;
    
    open(my $fh,"<",$path) || ATTX::File->throw("Cannot read file $file: $!");
    my %data;
    while (my $line = <$fh>) {
        chomp($line);
        $line=~/^(\w+): (.*?)/;
        $data{$1}=$2;
    }

    my $task = App::TimeTracker::Task->new( \%data );
    $task->_path($path);
    return $task;

}

=head4 write

   $task->write;
   $task->write( $basedir );

Serialises the data and writes it to disk.

If you got the object via L<read>, you don't need to specifiy the C<$basedir>. If this is the first time you want to C<write> the object, the C<$basedir> is neccesary.

=cut

sub write { die "not implemented yet" }

# 1; is boring
q{ listeing to:
    Beatles on the radio in the waiting room of the Allergieambulanz
};

__END__

=head1 AUTHOR

Thomas Klausner, C<< <domm at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008, 2009 Thomas Klausner, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
