#include "EXTERN.h"
#define PERL_IN_CLASS_C
#include "perl.h"
#include "proto.h"
#include "embed.h"
#include "XSUB.h"

MODULE = Class::CorX                    PACKAGE = Class::CorX

int
add_field ( SV* pkgname, SV* varname )
PROTOTYPE: $$
CODE:
{
	HV *stash = gv_stashsv( pkgname, GV_ADD );
	pad_add_name_sv( pTHX_ varname, padadd_FIELD, NULL, stash );

	struct xpvhv_aux *aux = HvAUX( stash );
	PADNAMELIST *fieldnames = aux->xhv_class_fields;

	RETVAL = -1;

	for ( SSize_t i = 0; fieldnames && i <= PadnamelistMAX( fieldnames ); i++ ) {
		PADNAME *pn = PadnamelistARRAY( fieldnames )[i];
		if ( sv_eq( PadnameSV( pn ), varname ) ) {
			PADOFFSET fieldix = PadnameFIELDINFO( pn )->fieldix;
			RETVAL = fieldix;
		}
	}
}
OUTPUT: RETVAL

void
add_param ( SV* pkgname, SV* varname, SV* paramname )
PROTOTYPE: $$$
CODE:
{
	HV *stash = gv_stashsv( pkgname, GV_ADD );
	struct xpvhv_aux *aux = HvAUX( stash );
	PADNAMELIST *fieldnames = aux->xhv_class_fields;

	for ( SSize_t i = 0; fieldnames && i <= PadnamelistMAX( fieldnames ); i++ ) {
		PADNAME *pn = PadnamelistARRAY( fieldnames )[i];
		if ( sv_eq( PadnameSV( pn ), varname ) ) {
			PADOFFSET fieldix = PadnameFIELDINFO( pn )->fieldix;
			PadnameFIELDINFO( pn )->paramname = SvREFCNT_inc( paramname );
			if( ! aux->xhv_class_param_map ) {
				aux->xhv_class_param_map = newHV();
			}
			(void) hv_store_ent( aux->xhv_class_param_map, paramname, newSVuv( fieldix ), 0 );
		}
	}
}

void
add_ADJUST ( SV* pkgname, CV* cb )
PROTOTYPE: $$
CODE:
{
	HV *stash = gv_stashsv( pkgname, GV_ADD );
	SvREFCNT_inc( cb );
	class_add_ADJUST( stash, cb );
}
