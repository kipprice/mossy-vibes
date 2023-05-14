import React, { PropsWithChildren } from 'react';

export type SocialLinkProps = PropsWithChildren & {
    title: string;
};

export const SocialLink: React.FC<SocialLinkProps> = ({ children, title }) => {
    return(
        <div className='flex flex-col items-center justify-center gap-1'>
            <div className='text-2xl border-b-2 border-dotted border-off-white text-center w-full'>
                {title}
            </div>
            <div className='flex items-center justify-center gap-4'>

            {children}
            </div>
        </div>
    );
};
