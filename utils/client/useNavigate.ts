import { useRouter } from "next/navigation"

export const useNavigate = () => {
    const router = useRouter()
    return (url: string | -1) => {
        if (url === -1) {
            return router.back()
        } else {
            return router.push(url)
        }
    }
}