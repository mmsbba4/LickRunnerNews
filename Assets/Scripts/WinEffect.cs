using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace Lick
{
    public class WinEffect : MonoBehaviour
    {
        public UnityEvent OnWin;
        private void OnTriggerEnter(Collider other)
        {
            if (other.GetComponent<PlayerMove>() != null)
            {
                OnWin.Invoke();
            }
    }
    }
}

