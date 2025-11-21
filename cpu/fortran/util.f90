! util.f90
module util_mod
contains

subroutine fill_random(M, N)
    implicit none
    integer, intent(in) :: N
    real, dimension(N,N), intent(out) :: M
    integer :: i, j

    call random_seed()
    do i = 1, N
        do j = 1, N
            call random_number(M(i,j))
        end do
    end do
end subroutine fill_random


logical function approx_equal(A, B, N, tol)
    implicit none
    integer, intent(in) :: N
    real, dimension(N,N), intent(in) :: A, B
    real, intent(in) :: tol
    integer :: i, j

    approx_equal = .true.
    do i = 1, N
        do j = 1, N
            if (abs(A(i,j) - B(i,j)) > tol) then
                approx_equal = .false.
                return
            end if
        end do
    end do
end function approx_equal

subroutine reference_matmul(A, B, C, N)
    implicit none
    integer, intent(in) :: N
    real, dimension(N,N), intent(in) :: A, B
    real, dimension(N,N), intent(out) :: C
    integer :: i, j, k
    real :: sum

    do i = 1, N
        do j = 1, N
            sum = 0.0
            do k = 1, N
                sum = sum + A(i,k) * B(k,j)
            end do
            C(i,j) = sum
        end do
    end do
end subroutine reference_matmul

end module util_mod
