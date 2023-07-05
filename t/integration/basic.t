use v5.38;
use experimental 'class';
use Class::CorX ();

my $x = 0;
my $n;

class Foo {
	
	BEGIN {
		$n = Class::CorX::add_field( 'Foo', '$bar' );
		Class::CorX::add_ADJUST( 'Foo', sub { ++$x } );
	}

	method set_bar ( $value ) {
		$bar = $value;
		return $self;
	}

	method get_bar () {
		return $bar;
	}
}

use Test2::V0;
use Tuple::Munge qw( tuple_length );

is $n, 0;

my $o = Foo->new;
is $o->set_bar( 33 ), $o;
is $o->get_bar, 33;

is tuple_length( $o ), 1;

is $x, 1;

done_testing;
