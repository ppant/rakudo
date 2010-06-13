## $Id$

=head1 NAME

src/classes/Positional.pir - Positional Role

=head1 DESCRIPTION

=cut

=item !postcircumfix:<[ ]>

Because foreign (non-Rakudo) Parrot objects generally won't
understand the "postcircumfix:<[ ]>" method, we generate
postcircumfix as a private call to this function, and this
function then delegates to the appropriate method.  For PMCs
that don't have a postcircumfix:<[ ]> method, we directly
use the one in Positional.

=cut

.namespace []
.sub '!postcircumfix:<[ ]>'
    .param pmc invocant
    .param pmc args            :slurpy
    $I0 = can invocant, 'postcircumfix:<[ ]>'
    if $I0 goto object_method
    $I0 = isa invocant, 'Mu'
    if $I0 goto object_method
  foreign:
    # XXX not a good idea, this relies on the method being in the namespace
    $P0 = get_hll_global ['Positional[::T]'], 'postcircumfix:<[ ]>'
    .tailcall invocant.$P0(args :flat)
  object_method:
    .tailcall invocant.'postcircumfix:<[ ]>'(args :flat)
.end


=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

