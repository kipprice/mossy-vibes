import React from "react";
import { SocialLink } from "./SocialLink";
import { generateShareLinks } from "../../../utils/client/share";
import FeatherIcon from "feather-icons-react";
import { Icon } from "../Icon";
export type SocialLinksProps = {};

export const SocialLinks: React.FC<SocialLinksProps> = ({}) => {
  const links = generateShareLinks();

  return (
    <div className="w-full flex flex-col gap-4 pb-4">
      <div className="text-center font-light">
        Want to help us keep Mossy Vibes going strong?
      </div>
      <div className="flex px-8 w-full justify-between items-start">
        {/* <SocialLink title="Follow">
          <a href="https://instagram.com/mossy_vibes_app" className="p-2" title='follow us on instagram'>
            <FeatherIcon icon="instagram" size={24} />
          </a>
        </SocialLink> */}
        <SocialLink title="Share">
          <a href={links.email} className="p-2" title='share through email'>
            <FeatherIcon icon="mail" size={24} />
          </a>
          <a href={links.facebook} className="p-2" title='share on facebook'>
            <FeatherIcon icon="facebook" size={24} />
          </a>
          <a href={links.twitter} className="p-2" title='share on twitter'>
            <FeatherIcon icon="twitter" size={24} />
          </a>
        </SocialLink>
        <SocialLink title="Donate">
          <a
            className={`text-off-white pt-1`}
            href="https://buymeacoffee.com/mossyvibes"
            title='donate or subscribe on Buy Me a Coffee'
          >
            <Icon iconFileName="bmc-logo" className="w-8 h-8" />
          </a>
        </SocialLink>
      </div>
    </div>
  );
};
