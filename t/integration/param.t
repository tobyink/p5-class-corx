use v5.38;
use experimental 'class';
use Class::CorX ();

class Foo {
	BEGIN {
		# field $bar :param(xyz);
		Class::CorX::add_field( __PACKAGE__, '$bar' );
		Class::CorX::add_param( __PACKAGE__, '$bar', 'xyz' );
	}
	method get_bar () {
		return $bar;
	}
}

use Test2::V0;
use Tuple::Munge qw( tuple_length );

my $e = dies {
	my $bad = Foo->new();
};

like $e, qr/^Required parameter 'xyz' is missing for "Foo" constructor/;

my $o = Foo->new( xyz => 33 );

todo "not currently working" => sub {
	is $o->get_bar, 33;
};

is tuple_length( $o ), 1;

done_testing;
