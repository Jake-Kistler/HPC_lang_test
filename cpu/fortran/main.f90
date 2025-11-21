! main.f90
program fortran_cpu_test
    use matmul_mod
    use util_mod
    implicit none

    integer, parameter :: num_sizes = 5
    integer :: sizes(num_sizes) = (/ 64, 128, 256, 512, 1024 /)
    integer :: N, i
    real :: t0, t1, elapsed
    logical :: ok

    real, allocatable :: A(:,:), B(:,:), C(:,:), R(:,:)
    character(len=128) :: fname_time, fname_verify
    integer :: unit_time, unit_verify

    ! --- properly name CSVs in the results/ folder ---
    fname_time   = "../../results/results_fortran_cpu_baseline.csv"
    fname_verify = "../../results/results_fortran_cpu_verify.csv"

    open(newunit=unit_time, file=fname_time,   status="replace")
    open(newunit=unit_verify, file=fname_verify, status="replace")

    ! Clean headers (no leading spaces)
    write(unit_time,*)   "N,time_ms"
    write(unit_verify,*) "N,correct"

    do i = 1, num_sizes
        N = sizes(i)
        print *, " Running N=", N

        allocate(A(N,N), B(N,N), C(N,N), R(N,N))

        ! Fill matrices
        call fill_random(A, N)
        call fill_random(B, N)

        ! Reference version
        call reference_matmul(A, B, R, N)

        ! Timing
        call cpu_time(t0)
        call baseline_matmul(A, B, C, N)
        call cpu_time(t1)

        elapsed = (t1 - t0) * 1000.0

        ! Correctness check
        ok = approx_equal(C, R, N, 1.0e-3)

        ! --- Proper CSV formatting: N,time ---
        write(unit_time,'(I0,",",F10.4)') N, elapsed

        ! --- Correctness CSV: N,correctFlag ---
        write(unit_verify,'(I0,",",I0)') N, merge(1,0,ok)

        if (.not. ok) then
            print *, " ERROR at N=", N
            stop
        end if

        deallocate(A,B,C,R)
    end do

    close(unit_time)
    close(unit_verify)

    print *, " Done. CSVs written."

end program fortran_cpu_test
