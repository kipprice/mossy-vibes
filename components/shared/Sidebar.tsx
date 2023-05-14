import { motion } from "framer-motion";
import React from "react";
import { useNavigate } from "../../utils/client";


import { SocialLinks } from "./SocialLinks";

export type SidebarProps = {
  isSidebarVisible: boolean;
  setIsSidebarVisible: (b: boolean) => void;
};

export const Sidebar: React.FC<SidebarProps> = ({
  isSidebarVisible,
  setIsSidebarVisible,
}) => {
  const navigate = useNavigate();


  return (
    <motion.div
      className="w-full h-full fixed left-0 top-0 bg-off-black bg-opacity-50 z-30"
      initial={{ opacity: 0, pointerEvents: "none" }}
      animate={{
        opacity: isSidebarVisible ? 1 : 0,
        pointerEvents: isSidebarVisible ? "auto" : "none",
      }}
      onClick={() => setIsSidebarVisible(false)}
    >
      <motion.div
        className="w-4/5 lg:w-2/5 h-full absolute bg-green-dark p-4 flex flex-col gap-8"
        initial={{ left: "100%" }}
        animate={{ left: isSidebarVisible ? '20%' : "100%" }}
      >
        {/* top section: navigation */}
        <button className={sidebarButtonClass} onClick={() => navigate("/")}>
          Home
        </button>

        <button
          className={sidebarButtonClass}
          onClick={() => navigate("/exercises")}
        >
          Exercises
        </button>

        <button
          className={sidebarButtonClass}
          onClick={() => navigate("/settings")}
        >
          Settings
        </button>

        {/* bottom section: about + social */}
        <div className="h-12" />
        <button
          className={sidebarButtonClass}
          onClick={() => navigate("/about")}
        >
          About Mossy Vibes
        </button>
        <div className="flex-grow" />

        <SocialLinks />
      </motion.div>
    </motion.div>
  );
};

const sidebarButtonClass =
  "hover:bg-off-white hover:bg-opacity-30 w-full px-4 py-2 text-2xl transition-all rounded-lg";
