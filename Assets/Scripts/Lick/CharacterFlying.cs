using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class CharacterFlying : MonoBehaviour
    {
        public Rigidbody rb;
        public bool is_flying;
        public void StartFly()
        {
            is_flying = true;
        }
        void Update()
        {
            if (!is_flying) return;
            if (rb.velocity.magnitude <= 1)
            {
                LickRunner.instance.EndFly();
            }
        }

    }
}

