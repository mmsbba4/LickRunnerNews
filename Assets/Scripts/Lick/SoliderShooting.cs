using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RootMotion.FinalIK;
namespace Lick
{
    public class SoliderShooting : MonoBehaviour
    {
        public AimIK my_aim;
        public Animator m_ammin;
        public Transform spawn_point, aim_rig;
        public GameObject bullet;
        public void StartShooting(Transform target)
        {
            my_aim.solver.target = target;
            my_aim.solver.poleTarget = target;
            my_aim.enabled = true;
            m_ammin.SetFloat("Aim Forward", 1);
            StartCoroutine(shooting());
        }
        private void Update()
        {
            spawn_point.transform.position = aim_rig.position;
            spawn_point.transform.rotation = aim_rig.rotation;
        }
        IEnumerator shooting()
        {
            float tmp = 10;
            for (int i = 0; i < tmp; i++)
            {
                yield return new WaitForSeconds(0.1f);
                Instantiate(bullet, spawn_point.position, spawn_point.rotation);
            }
        }
    }

}
