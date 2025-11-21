! matmul.f90
module matmul_mod
contains

subroutine baseline_matmul(A, B, C, N)
    implicit none
    integer, intent(in) :: N
    real, dimension(N,N), intent(in) :: A,B
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
end subroutine baseline_matmul

end module matmul_mod