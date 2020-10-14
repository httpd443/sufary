#-*- perl -*-
# $Id: DID.pm,v 1.4 2000/07/08 01:12:06 kazuma-t Exp $

package DID;
require 5.000;
require DynaLoader;
@ISA = qw(DynaLoader);

# Constructor
sub new {
    my ($class,$didfile) = @_;
    my $self = {};
    bless $self, $class;

    return undef unless (defined $didfile);

    $self->{'did'} = suf_opendid($didfile);
    if (!($self->{'did'})) {
	return undef;
    }
    $self->{'file'} = $didfile;
    $self->{'size'} = suf_did_size($self->{'did'});

    return $self;
}

# Destructor
sub DESTROY {
    my $self = shift;

    suf_closedid($self->{'did'});

    print "memory leak check: ", suf_memory_leak_check(), "\n";
}

# Search
sub didsearch {
    my ($self, $target) = @_;
    
    return suf_didsearch($self->{'did'}, $target);
}
bootstrap DID;
1;
