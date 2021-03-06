"""
The module series exports functions to compute power series solutions with
Newton's method in double, double double, or quad double precision.
"""

def standard_newton_series(pols, sols, idx=1, nbr=4, verbose=True):
    r"""
    Computes series in double double precision for the polynomials
    in *pols*, where the leading coefficients are the solutions in *sols*.
    On entry are the following five parameters:

    *pols*: a list of string representations of polynomials,

    *sols*: a list of solutions of the polynomials in *pols*,

    *idx*: index of the series parameter, by default equals 1,

    *nbr*: number of steps with Newton's method,

    *verbose*: whether to write intermediate output to screen or not.

    On return is a list of lists of strings.  Each lists of strings
    represents the series solution for the variables in the list *pols*.
    """
    from phcpy.solver import number_of_symbols
    from phcpy.interface import store_standard_solutions
    from phcpy.interface import store_standard_system, load_standard_system
    from phcpy.phcpy2c2 import py2c_standard_Newton_series as newton
    from phcpy.phcpy2c2 import py2c_syspool_standard_size as poolsize
    from phcpy.phcpy2c2 import py2c_syspool_copy_to_standard_container
    nbsym = number_of_symbols(pols)
    if verbose:
        print "the polynomials :"
        for pol in pols:
            print pol
        print "Number of variables :", nbsym
    store_standard_system(pols, nbvar=nbsym)
    store_standard_solutions(nbsym, sols)
    fail = newton(idx, nbr, int(verbose))
    size = (-1 if fail else poolsize())
    if verbose:
        if size == -1:
            print "An error occurred in the execution of Newton's method."
        else:
            print "Computed %d series solutions." % size
    result = []
    for k in range(1, size+1):
        py2c_syspool_copy_to_standard_container(k)
        sersol = load_standard_system()
        result.append(sersol)
    return result

def dobldobl_newton_series(pols, sols, idx=1, nbr=4, verbose=True):
    r"""
    Computes series in double double precision for the polynomials
    in *pols*, where the leading coefficients are the solutions in *sols*.
    On entry are the following five parameters:

    *pols*: a list of string representations of polynomials,

    *sols*: a list of solutions of the polynomials in *pols*,

    *idx*: index of the series parameter, by default equals 1,

    *nbr*: number of steps with Newton's method,

    *verbose*: whether to write intermediate output to screen or not.

    On return is a list of lists of strings.  Each lists of strings
    represents the series solution for the variables in the list *pols*.
    """
    from phcpy.solver import number_of_symbols
    from phcpy.interface import store_dobldobl_solutions
    from phcpy.interface import store_dobldobl_system, load_dobldobl_system
    from phcpy.phcpy2c2 import py2c_dobldobl_Newton_series as newton
    from phcpy.phcpy2c2 import py2c_syspool_dobldobl_size as poolsize
    from phcpy.phcpy2c2 import py2c_syspool_copy_to_dobldobl_container
    nbsym = number_of_symbols(pols)
    if verbose:
        print "the polynomials :"
        for pol in pols:
            print pol
        print "Number of variables :", nbsym
    store_dobldobl_system(pols, nbvar=nbsym)
    store_dobldobl_solutions(nbsym, sols)
    fail = newton(idx, nbr, int(verbose))
    size = (-1 if fail else poolsize())
    if verbose:
        if size == -1:
            print "An error occurred in the execution of Newton's method."
        else:
            print "Computed %d series solutions." % size
    result = []
    for k in range(1, size+1):
        py2c_syspool_copy_to_dobldobl_container(k)
        sersol = load_dobldobl_system()
        result.append(sersol)
    return result

def quaddobl_newton_series(pols, sols, idx=1, nbr=4, verbose=True):
    r"""
    Computes series in quad double precision for the polynomials
    in *pols*, where the leading coefficients are the solutions in *sols*.
    On entry are the following five parameters:

    *pols*: a list of string representations of polynomials,

    *sols*: a list of solutions of the polynomials in *pols*,

    *idx*: index of the series parameter, by default equals 1,

    *nbr*: number of steps with Newton's method,

    *verbose*: whether to write intermediate output to screen or not.

    On return is a list of lists of strings.  Each lists of strings
    represents the series solution for the variables in the list *pols*.
    """
    from phcpy.solver import number_of_symbols
    from phcpy.interface import store_quaddobl_solutions
    from phcpy.interface import store_quaddobl_system, load_quaddobl_system
    from phcpy.phcpy2c2 import py2c_quaddobl_Newton_series as newton
    from phcpy.phcpy2c2 import py2c_syspool_quaddobl_size as poolsize
    from phcpy.phcpy2c2 import py2c_syspool_copy_to_quaddobl_container
    nbsym = number_of_symbols(pols)
    if verbose:
        print "the polynomials :"
        for pol in pols:
            print pol
        print "Number of variables :", nbsym
    store_quaddobl_system(pols, nbvar=nbsym)
    store_quaddobl_solutions(nbsym, sols)
    fail = newton(idx, nbr, int(verbose))
    size = (-1 if fail else poolsize())
    if verbose:
        if size == -1:
            print "An error occurred in the execution of Newton's method."
        else:
            print "Computed %d series solutions." % size
    result = []
    for k in range(1, size+1):
        py2c_syspool_copy_to_quaddobl_container(k)
        sersol = load_quaddobl_system()
        result.append(sersol)
    return result

def viviani(prc='d'):
    """
    Returns the system which stores the Viviani curve,
    with some solutions intersected with a plane,
    in double ('d'), double double ('dd'), or quad double('qd') precision.
    """
    from phcpy.solver import solve
    pols = ['(1-s)*y + s*(y-1);', \
            'x^2 + y^2 + z^2 - 4;' , \
            '(x-1)^2 + y^2 - 1;', \
            's;']
    sols = solve(pols, silent=True, precision=prc)
    print "The solutions on the Viviani curve :"
    for sol in sols:
        print sol
    return (pols[:3], sols)

def test(precision='d'):
    """
    Tests the application of Newton's method to compute power
    series solutions of a polynomial system.
    """
    (pols, sols) = viviani(precision)
    if precision == 'd':
        sersols = standard_newton_series(pols, sols)
    elif precision == 'dd':
        sersols = dobldobl_newton_series(pols, sols)
    elif precision == 'qd':
        sersols = quaddobl_newton_series(pols, sols)
    for series in sersols:
        print series

if __name__ == "__main__":
    test('d')
    test('dd')
    test('qd')
