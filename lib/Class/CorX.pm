package Class::CorX;

use 5.038000;
use strict;
use warnings;
use XSLoader ();

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.000_001';

__PACKAGE__->XSLoader::load( $VERSION );

1;

=head1 NAME

Class::CorX - tools for manipulating classes built via the Perl 5.38 C<class> keyword

=head1 SYNOPSIS

  use v5.38;
  use experimental 'class';
  use Class::CorX;
  
  class Foo {
    BEGIN {
      Class::CorX::add_field( 'Foo', '$bar' );
    }
    
    method set_bar ( $value ) {
      $bar = $value;
      return $self;
    }
    
    method get_bar () {
      return $bar;
    }
  }

=head1 FUNCTIONS

Low-level functions for manipulating classes and fields. This module will be
deprecated once Perl core classes get a MOP.

=head2 C<< add_field( $class_name, $field_name ) >>

Adds a field to a class.

Returns a number indicating the slot within the object tuple that will
be used for this field.

=head2 C<< add_param( $class_name, $field_name, $param_name ) >>

Adds a constructor parameter for a field to a class.

The field must have already been declared, using C<add_field> or the
Perl 5.38 native C<field> keyword.

Fields cannot have multiple parameters.

=head2 C<< add_ADJUST( $class_name, sub { ... } ) >>

Adds an ADJUST block to a class.

=head1 SEE ALSO

L<perlclass>, L<Tuple::Munge>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2023 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
